class ResumePdf < Prawn::Document
  
  def initialize(resume)
    # pass in new default settings to PDF via super.
    super(top_margin: 50, left_margin: 50, right_margin: 50, bottom_margin: 35)
    # provide access to the resume data now
    @resume = resume

    create_pdf
  end

  def create_pdf
    # controller method that calls each section separately
    contact_info_pdf
    job_info_pdf
    school_info_pdf
  end

  
  private

  def contact_info_pdf
    #----------------CONTACT---------------------
    #now we can pass in the copy for the resume
    # contact info at top, check for the optional fields, such as 
    # middle name, address2, twitter, homepage
    
    contact = @resume.contacts.find(1)
    if contact.middle_name
      header = "#{contact.first_name} #{contact.middle_name} #{contact.last_name}"
    else
      header =  "#{contact.first_name} #{contact.last_name}"
    end

    output_header(header)

    if contact.address2
      text "#{contact.address1}, #{contact.address2}"
      text "#{contact.city}, #{contact.state} #{contact.zip}"
    else
      text "#{contact.address1}"
      text "#{contact.city}, #{contact.state} #{contact.zip}"
    end

    text "#{contact.phone}"
    text "#{contact.email}"

    if contact.twitter
      text "Twitter: @#{contact.twitter}"
    end

    if contact.homepage
      text "Web: #{contact.homepage}"
    end

    move_down (20)
  end

  def job_info_pdf

    #----------------JOB--------------------------
    # loop through and print job info
    header = "Employment"
    output_subheader(header)

    @resume.jobs.each do |job|
      text "#{job.company}, #{job.title}"
      if job.end_date
        text "#{job.start_date} - #{job.end_date}"
      else
        text "#{job.start_date} - Current"
      end
      text "#{job.description}"
      move_down(10)
    end
    move_down(5)
  end

  def school_info_pdf
    #----------------SCHOOL---------------------
    #loop through and print school info
    header = "Education"
    output_subheader(header)
        # loop through and print job info
    @resume.schools.each do |school|
      text "#{school.school_name}, #{school.degree} in #{school.major}"
      if school.end_date
        text "#{school.start_date} - #{school.end_date}"
      else
        text "#{school.start_date} - Current"
      end
      text "#{school.description}"
      move_down(10)
    end

  end

  def output_header(header)
    header_font
    text "#{header}", size:24
    body_font
  end

  def output_subheader(header)
    header_font
    text "#{header}", size:20
    body_font
  end

  #font methods so you can propagate changes once across multiple other methods
  def header_font
    font("Helvetica")
  end

  def body_font
    font("Times-Roman")
  end
end
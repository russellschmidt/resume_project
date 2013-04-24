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
    objective_pdf
    job_info_pdf
    school_info_pdf
  end

  
  private

  def contact_info_pdf
    #----------------CONTACT---------------------
    #now we can pass in the copy for the resume
    # contact info at top, check for the optional fields, such as 
    # middle name, address2, twitter, homepage
    
    contact = @resume.contacts.first
    if contact.middle_name
      header = "#{contact.first_name} #{contact.middle_name} #{contact.last_name}"
    else
      header =  "#{contact.first_name} #{contact.last_name}"
    end

    output_header(header, 20, :center)

    fontsize = 12
    if contact.address2
      text "#{contact.address1}, #{contact.address2}", align: :center, size: fontsize 
      text "#{contact.city}, #{contact.state} #{contact.zip}", align: :center, size: fontsize 
    else
      text "#{contact.address1}", align: :center, size: fontsize 
      text "#{contact.city}, #{contact.state} #{contact.zip}", align: :center, size: fontsize 
    end

    text "#{contact.phone}", align: :center, size: fontsize 
    text "#{contact.email}", align: :center, size: fontsize  

    if contact.twitter
      text "Twitter: <link href='http://www.twitter.com/#{contact.twitter}'><color rgb='3B5998'>@#{contact.twitter}</color></link>", 
      align: :center, inline_format: true, size: fontsize 
    end

    if contact.homepage
      text "Homepage: <link href='#{contact.homepage}'><color rgb='210664'>#{contact.homepage}</color></link>", align: :center, inline_format: true, size: fontsize  
    end
    move_down (5)
    
    # draw a horizontal line
    stroke do
      horizontal_rule
    end

    move_down (20)
  end


  def objective_pdf
    #--------------OBJECTIVE----------------------
    # loop through the resume's metadata type info
    header = "Objective"
    output_header(header, 18, :left)
     
    text "<b>Position:</b> #{@resume.position}", inline_format: true
    text "<b>Description:</b> #{@resume.description}", inline_format: true

    move_down (10)
  end


  def job_info_pdf

    #----------------JOB--------------------------
    # loop through and print job info
    header = "Employment"
    output_header(header, 18, :left)

    @resume.jobs.each do |job|
      header = "#{job.company}, #{job.title}"
      output_header(header, 14, :left)
      if job.end_date
        text "#{job.start_date.strftime("%B %Y")} - #{job.end_date.strftime("%B %Y")}"
      else
        text "#{job.start_date.strftime("%B %Y")} - Current"
      end
      text "#{job.description}", align: :justify
      move_down(10)
    end
    move_down(5)
  end

  def school_info_pdf
    #----------------SCHOOL---------------------
    #loop through and print school info
    header = "Education"
    output_header(header, 18, :left)
        # loop through and print job info
    @resume.schools.each do |school|
      header = "#{school.school_name}, #{school.degree} in #{school.major}"
      output_header(header, 14, :left)
      if school.end_date
        text "#{school.start_date.strftime("%B %Y")} - #{school.end_date.strftime("%B %Y")}"
      else
        text "#{school.start_date.strftime("%B %Y")} - Current"
      end
      text "#{school.description}", align: :justify
      move_down(10)
    end

  end

  def output_header(header, textsize, alignment)
    header_font
    text "#{header}", size:textsize, align: alignment
    body_font
  end

  #font methods so you can propagate changes once across multiple other methods
  def header_font
  # Registering the Ostrich TTF font
  font_families.update("ostrich-bold-webfont" => {
    normal: "./app/assets/fonts/ostrich-bold-webfont.ttf"})

    font "ostrich-bold-webfont"
  end

  def body_font
    font "Times-Roman"
  end
end
# Strong Parameters
# replace all params(:object) with object_params, based off private method in controller
# Go to https://github.com/rails/strong_parameters

ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)
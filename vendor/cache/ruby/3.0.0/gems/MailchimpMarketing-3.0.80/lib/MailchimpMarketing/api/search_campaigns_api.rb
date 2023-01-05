=begin
#Mailchimp Marketing API

#No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

OpenAPI spec version: 3.0.80
Contact: apihelp@mailchimp.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.12

=end

require 'uri'

module MailchimpMarketing
  class SearchCampaignsApi
    attr_accessor :api_client

    def initialize(api_client)
      @api_client = api_client
    end

    # Search campaigns
    def search(query, opts = {})
      fail ArgumentError, "Missing required param: 'query'" if query.nil?

      query_params = {}
      query_params[:'query'] = query
      query_params[:'fields'] = @api_client.build_collection_param(opts[:'fields'], :csv) if !opts[:'fields'].nil?
      query_params[:'exclude_fields'] = @api_client.build_collection_param(opts[:'exclude_fields'], :csv) if !opts[:'exclude_fields'].nil?
      post_body = nil

      local_var_path = '/search-campaigns'
      data = @api_client.call_api(:GET, local_var_path,
        :query_params => query_params,
        :body => post_body)
      return data
    end
  end
end

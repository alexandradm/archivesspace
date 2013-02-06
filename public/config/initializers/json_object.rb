require "jsonmodel"

JSONModel::init(:client_mode => true,
                :priority => :high,
                :url => AppConfig[:backend_url],
                :allow_other_unmapped => AppConfig[:allow_other_unmapped])


if not ENV['DISABLE_STARTUP']

  JSONModel::add_error_handler do |error|
    if error["code"] == "SESSION_GONE"
      raise ArchivesSpacePublic::SessionGone.new("Your backend session was not found")
    end
    if error["code"] == "SESSION_EXPIRED"
      raise ArchivesSpacePublic::SessionExpired.new("Your session expired due to inactivity. Please sign in again.")
    end
  end

end


include JSONModel

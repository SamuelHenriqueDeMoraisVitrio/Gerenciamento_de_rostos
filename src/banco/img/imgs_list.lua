

---@param banco DtwResource
---@param user_finding DtwResource
---@return serjaoResponse
function List_imgs_banco(banco, user_finding)

    local dir_images = user_finding.sub_resource(IMGS_BANCO)

    banco.commit()

    local list = dir_images.map(
    function(element)

        local date = element.get_value_from_sub_resource(DATE)

        local convert_date = nil
        if date then
            convert_date = os.date(DATE_FORMATED, date)
        end

        return {
            id_foto = dtw.newPath(element.get_path_string()).get_only_name(),
            data = convert_date
        }
    end)

    return list
end
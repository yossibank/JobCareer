warn("PRがWIPになってるよ！🐶") if github.pr_title.include? "[WIP]"
warn("PRのタイトルが短すぎるよ！🐶") if github.pr_title.length < 5
warn("PRにタイトルが書かれてないよ！🐶") if github.pr_title.length == 0
warn("PRの説明が短すぎるよ！レビュアーが見て分かる説明を書いてね！🐶") if github.pr_body.length < 5
warn("PRにassigneeが設定されてないよ！🐶") unless github.pr_json["assignee"]

github.dismiss_out_of_range_messages
swiftlint.config_file = '.swiftlint.yml'
module Admin
  module QuestionsHelper
    def bar_param(q_level)
      case q_level
      when 'beginner'
        { level: q_level, width: "40%", color: "success" }
      when 'good'
        { level: q_level, width: "66%", color: "warning" }
      when 'strong'
        { level: q_level, width: "100%", color: "danger" }
      end
    end
  end
end

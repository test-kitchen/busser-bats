# -*- encoding: utf-8 -*-
ignore %r{^\.gem/}

def rubocop_opts
  { :all_on_start => false, :keep_failed => false, :cli => "-r finstyle -D" }
end

group :red_green_refactor, :halt_on_fail => true do
  guard :cucumber do
    watch(%r{^features/.+\.feature$})
    watch(%r{^features/support/.+$}) { "features" }
    watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
      Dir[File.join("**/#{m[1]}.feature")][0] || "features"
    end
  end

  guard :rubocop, rubocop_opts do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard :cane do
    watch(%r{.*\.rb})
    watch(".cane")
  end
end

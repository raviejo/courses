#### MAIN SCOPE BEGIN ####

#### INHERITTED SCOPE BEGIN ####
class C
  SOME_CONSTANT = self # 4
end

SOME_CONSTANT = self # 5
#### INHERITTED SCOPE END ####

#### LEXICAL SCOPE BEGIN ####
module Z
  SOME_CONSTANT = self # 3
  module A
    SOME_CONSTANT = self # 2
    class B < C
      SOME_CONSTANT = self # 1
      def what_am_i
        SOME_CONSTANT # Constant resolution (search scope), lexically, then by inheritance, then top level.
      end
    end
  end
end
#### LEXICAL SCOPE END. ####

#### MAIN SCOPE BEGIN ####
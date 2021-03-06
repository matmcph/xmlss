require "assert"
require 'xmlss/table'

module Xmlss
  class TableTest < Assert::Context
    desc "Xmlss::Table"
    before { @tbl = Table.new }
    subject { @tbl }

    should have_accessor :columns, :rows

    should "set it's defaults" do
      assert_equal [], subject.columns
      assert_equal [], subject.rows
    end

    should "allow defining a rows/columns at init" do
      tbl = Table.new({
        :columns => [Column.new],
        :rows => [Row.new]
      })

      assert_equal 1, tbl.columns.size
      assert_kind_of Column, tbl.columns.first
      assert_equal 1, tbl.rows.size
      assert_kind_of Row, tbl.rows.first
    end

  end

  class TableXmlTest < TableTest
    desc "for generating XML"
    should have_reader :xml
    should_build_node

  end

  class TableRowsColsTest < TableTest
    desc "when using rows/columns"
    before do
      subject.columns << Column.new
      r = Row.new
      r.cells << Cell.new
      subject.rows << r
    end

    should "should build a table object" do
      assert_equal 1, subject.columns.size
      assert_kind_of Column, subject.columns.first
      assert_equal 1, subject.rows.size
      assert_kind_of Row, subject.rows.first
    end

  end

end

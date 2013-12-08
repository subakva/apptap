require 'spec_helper'

describe 'apptap update' do
  it 'adds new formulae' do
    expect {
      add_local_formula
      call_apptap('update')
    }.to change { File.symlink?(brew_linked_formula_path) }.from(false).to(true)
  end

  it 'removes missing formulae' do
    add_local_formula
    call_apptap('update')

    expect {
      remove_local_formula
      call_apptap('update')
    }.to change { File.symlink?(brew_linked_formula_path) }.from(true).to(false)
  end
end

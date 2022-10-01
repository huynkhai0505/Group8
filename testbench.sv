// Testbench
module test;

  logic clk, rst, temp36, temp38, aa1, aa2, fan1, fan2;

  // Instantiate design under test
  sync duts(clk, ~rst, temp36, temp38, fan1, fan2);
  async duta(rst, temp36, temp38, aa1, aa2);
  
  // generate clock
  always begin
    clk = 0; #5; clk = 1; #5;
  end  
        
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end

  initial begin
	rst = 0; temp36 = 0; temp38 = 0; 
    #50 rst = 1;
    #50 rst = 0;
    #50 temp36 = 1;
    $display(temp36, fan1);
    #50 temp38 = 1;
    $display(temp38, fan1);
    #50 temp38 = 0;
    $display(temp38, fan1);
    #50 temp38 = 1;
    $display(temp38, fan1);
    #50 temp38 = 0;
    $display(temp38, fan1);
    #50 temp38 = 1;
    $display(temp38, fan1);
    #50 temp38 = 0;
    $display(temp38, fan1);
    #50 temp36 = 0;
    $display(temp36, fan1);
    #50 temp36 = 1;
    $display(temp36, fan1);
    #50 temp36 = 0;
    $display(temp36, fan1);
    #50 temp36 = 1;
    $display(temp36, fan1);
    #50 temp36 = 1;
    $display(temp36, fan1);
    #50 temp36 = 0;
    $display(temp36, fan1);
    #50 $finish;
  end
endmodule

// synchronous behavioral design
module sync (Clock, Resetn, temp36, temp38, fan1, fan2);
  input Clock, Resetn, temp36, temp38;
  output fan1, fan2;
  reg [3:1] y, Y;
  parameter [3:1] A1 = 3'b000, B1 = 3'b001, C1 = 3'b010, A2 = 3'b011, B2 = 3'b100, C2 = 3'b101;
  // Define the next state combinational circuit
  always @(temp36, temp38, y)
    case (y)
      A1: if (temp36) Y = B1;
          else     Y = A1;
      A2: if (temp36) Y = B2;
          else     Y = A2;
      B1: if (temp38) Y = C1;
          else 
            if (temp36) Y = B1;
            else     Y = A2;
      B2: if (temp38)   Y = C2;
          else 
            if (temp36) Y = B2;
            else     Y = A1;
      C1: if (temp38) Y = C1;
          else     Y = B2;
      C2: if (temp38) Y = C2;
          else     Y = B1;
      default:     Y = 2'bxx;
    endcase
  // Define the sequential block  
  always @(negedge Resetn, posedge Clock)
    if (Resetn == 0)  y <= A1;
    else        y <= Y;
  // Define output  
  assign fan1 = (y == A1 || y == A2 || y == B1);
  assign fan2 = (y == A1 || y == A2 || y == B2);
endmodule


// asynchronous structural design
module async (
  input rst, temp36, temp38,
  output fan1, fan2);
  wire x, y;
  
  //module jkff(input clk, rst, j, k, output reg q, nq);
  jkff q0 (temp36 ^ temp38, rst, 1'b1, 1'b1, x, y); 
  assign fan1 = (~temp36 & ~temp38) | (temp36 & ~temp38 & y);
  assign fan2 = (~temp36 & ~temp38) | (temp36 & ~temp38 & x);
endmodule

module jkff (
  input  clk, rst,
  input  j,
  input  k,
  output reg q, nq);

  always @(negedge clk or posedge rst)
    if (rst)
      q = 0;
    else
      case({j,k})
      2'b0_0 : q = q   ;
      2'b0_1 : q = 1'b0;
      2'b1_0 : q = 1'b1;
      2'b1_1 : q = ~q  ;
      endcase
  assign nq = ~q;
endmodule

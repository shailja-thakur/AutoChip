module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);
  
  // Define the states
  typedef enum logic [2:0] {
    S0,
    S1,
    S2
  } state_t
  
  // Define the outputs
  logic disc_out;
  logic flag_out;
  logic err_out;
  
  // Define the current state
  state_t state;
  
  // Define the next state and outputs
  always_ff @(posedge clk) begin
    if (reset) begin
      state <= S0;
      disc_out <= 0;
      flag_out <= 0;
      err_out <= 0;
    end else begin
      case(state)
        S0: begin
          if (in == 0) begin
            state <= S0;
            disc_out <= 0;
            flag_out <= 0;
            err_out <= 0;
          end else begin
            state <= S1;
            disc_out <= 0;
            flag_out <= 0;
            err_out <= 0;
          end
        end
        
        S1: begin
          if (in == 0) begin
            state <= S0;
            disc_out <= 0;
            flag_out <= 0;
            err_out <= 0;
          end else if (in == 1) begin
            state <= S2;
            disc_out <= 0;
            flag_out <= 0;
            err_out <= 0;
          end
        end
        
        S2: begin
          if (in == 0) begin
            state <= S0;
            disc_out <= 1;
            flag_out <= 0;
            err_out <= 0;
          end else if (in == 1) begin
            state <= S2;
            disc_out <= 0;
            flag_out <= 1;
            err_out <= 0;
          end else if (in == 7'b0111111) begin
            state <= S2;
            disc_out <= 0;
            flag_out <= 0;
            err_out <= 1;
          end
        end
      endcase
    end
  end
  
  // Assign the outputs
  assign disc = disc_out;
  assign flag = flag_out;
  assign err = err_out;
  
endmodule

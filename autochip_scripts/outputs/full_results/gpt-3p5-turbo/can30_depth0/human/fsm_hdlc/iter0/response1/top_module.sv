module top_module (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err
);
  
  reg [2:0] state;
  reg prev_bit;
  reg [2:0] next_state;
  reg [2:0] next_state_disc;
  reg [2:0] next_state_flag;
  reg [2:0] next_state_err;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;  // Initialize state to Idle
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      state <= next_state;
      disc <= 0;
      flag <= 0;
      err <= 0;
      
      case(state)
        3'b000: begin  // Idle
          if (in == 1) begin
            next_state_disc <= 3'b001;
            next_state_flag <= 3'b001;
            next_state_err <= 3'b010;
          end else begin
            next_state_disc <= 3'b000;
            next_state_flag <= 3'b000;
            next_state_err <= 3'b000;
          end
        end

        3'b001: begin  // Receive 1
          if (in == 1) begin
            next_state_disc <= 3'b010;
            next_state_flag <= 3'b000;
            next_state_err <= 3'b010;
          end else begin
            next_state_disc <= 3'b000;
            next_state_flag <= 3'b000;
            next_state_err <= 3'b000;
          end
        end

        3'b010: begin  // Receive flag bit pattern
          if (in == 1) begin
            next_state_disc <= 3'b010;
            next_state_flag <= 3'b011;
            next_state_err <= 3'b010;
          end else begin
            next_state_disc <= 3'b000;
            next_state_flag <= 3'b000;
            next_state_err <= 3'b000;
          end
        end

        3'b011: begin  // Receive flag bit pattern continued
          if (in == 1) begin
            next_state_disc <= 3'b010;
            next_state_flag <= 3'b011;
            next_state_err <= 3'b010;
          end else if (in == 0) begin
            next_state_disc <= 3'b010;
            next_state_flag <= 3'b100;
            next_state_err <= 3'b010;
          end
        end

        3'b100: begin  // Check for error condition
          if (in == 1) begin
            next_state_disc <= 3'b101;
            next_state_flag <= 3'b101;
            next_state_err <= 3'b101;
          end else begin
            next_state_disc <= 3'b000;
            next_state_flag <= 3'b011;
            next_state_err <= 3'b000;
          end
        end

        3'b101: begin  // Error
          if (in == 1) begin
            next_state_disc <= 3'b101;
            next_state_flag <= 3'b101;
            next_state_err <= 3'b101;
          end else begin
            next_state_disc <= 3'b000;
            next_state_flag <= 3'b000;
            next_state_err <= 3'b000;
          end
        end
      endcase
    end
  end

  always @(state) begin
    case(state)
      3'b000: begin  // Idle
        disc <= 0;
        flag <= 0;
        err <= 0;
      end

      3'b001: begin  // Receive 1
        disc <= 0;
        flag <= 0;
        err <= 0;
      end

      3'b010: begin  // Receive flag bit pattern
        disc <= 0;
        flag <= 0;
        err <= 0;
      end

      3'b011: begin  // Receive flag bit pattern continued
        disc <= 0;
        flag <= 0;
        err <= 0;
      end

      3'b100: begin  // Check for error condition
        disc <= 0;
        flag <= 0;
        err <= 1;
      end

      3'b101: begin  // Error
        disc <= 0;
        flag <= 0;
        err <= 1;
      end
    endcase
  end
endmodule

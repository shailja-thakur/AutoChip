module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

// Declare state register and next state variable
reg [1:0] state, next_state;
  
// Declare registers and wire for shifting
reg [7:0] shift_reg;
wire [23:0] out_reg;

// Assign output
assign out_bytes = out_reg;
assign done = (state == 2'b11);

// Sequential logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        shift_reg <= 8'd0;
    end else begin
        state <= next_state;
        shift_reg <= {shift_reg[15:0], in};
    end
end

// Combinational logic
always @* begin
    case (state)
        2'b00: begin // BYTE1
            if (in[2] == 1'b1)
                next_state = 2'b01; // Transition to BYTE2
            else
                next_state = 2'b00; // Transition to BYTE1
        end
        2'b01: begin // BYTE2
            next_state = 2'b10; // Transition to BYTE3
        end
        2'b10: begin // BYTE3
            next_state = 2'b11; // Transition to DONE
        end
        2'b11: begin // DONE
            if (in[2] == 1'b0)
                next_state = 2'b00; // Transition to BYTE1
            else
                next_state = 2'b11; // Stay in DONE
        end
    endcase
    out_reg = (next_state == 2'b11) ? shift_reg : out_reg;
end

endmodule

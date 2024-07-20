module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Define the states
parameter BYTE1 = 0;
parameter BYTE2 = 1;
parameter BYTE3 = 2;
parameter DONE = 3;

// Define the current state and next state variables
reg [1:0] state, next_state;

// Define the register for shifting the input
reg [31:0] shift_reg;

// Always block for state transitions and output updates
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        shift_reg <= 0;
        done <= 0;
    end else begin
        state <= next_state;
        shift_reg <= {shift_reg[23:0], in};
        done <= (state == DONE);
    end
end

// Combinational logic for next state calculation
always @(*) begin
    case (state)
        BYTE1: begin
            if (in[2])
                next_state = BYTE2;
            else
                next_state = BYTE1;
        end
        BYTE2: begin
            if (in[2])
                next_state = BYTE3;
            else
                next_state = BYTE1;
        end
        BYTE3: begin
            if (in[2])
                next_state = DONE;
            else
                next_state = BYTE1;
        end
        DONE: begin
            next_state = BYTE1;
        end
    endcase
end

// Assign the output register
always @(posedge clk) begin
    if (done)
        out_bytes <= shift_reg[23:0];
end

endmodule

module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

// Define states as parameters
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Define state register
reg [1:0] state;

// Define output register
reg [23:0] out_reg;

// Define done signal
reg done_signal;

// Assign initial values to state and out_reg
initial begin
    state <= BYTE1;
    out_reg <= 24'b0;
end

// State machine logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_reg <= 24'b0;
        done_signal <= 1'b0;
    end
    else begin
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1)
                    state <= BYTE2;
                else
                    state <= BYTE1;
            end
            BYTE2: begin
                if (in[2] == 1'b1)
                    state <= BYTE3;
                else
                    state <= BYTE1;
            end
            BYTE3: begin
                if (in[2] == 1'b1)
                    state <= DONE;
                else
                    state <= BYTE1;
            end
            DONE: begin
                if (in[2] == 1'b0)
                    state <= BYTE1;
                else
                    state <= DONE;
            end
        endcase
    end
end

// Output register update
always @(posedge clk) begin
    if (done_signal)
        out_bytes <= out_reg;
    out_reg <= {out_reg[15:0], in};
end

// Done signal assignment
always @(posedge clk) begin
    if (state == DONE)
        done_signal <= 1'b1;
    else
        done_signal <= 1'b0;
end

endmodule

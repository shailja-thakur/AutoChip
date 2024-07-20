module top_module (
    input clk,
    input in,
    input reset,
    output done
);

// Define the states
parameter START = 2'b00;
parameter DATA = 2'b01;
parameter STOP = 2'b10;

// Define the signal sizes
parameter BIT_WIDTH = 8;

// Define the internal signals
reg [1:0] state;
reg [BIT_WIDTH-1:0] data;
reg valid_data;

// Define the output signals
assign done = valid_data;

// Synchronous reset
always @(posedge clk) begin
    if (reset) begin
        state <= START;
        data <= 8'b0;
        valid_data <= 0;
    end else begin
        case(state)
            START: begin
                if (in == 1'b0) begin
                    state <= DATA;
                    data <= 8'b0;
                end
            end
            DATA: begin
                if (data == BIT_WIDTH-1) begin
                    state <= STOP;
                else begin
                    data <= data + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    valid_data <= 1;
                    state <= START;
                end
            end
        endcase
    end
end

endmodule

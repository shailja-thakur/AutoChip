module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

// Constants for states
parameter IDLE = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BITS = 2'b10;
parameter STOP_BIT = 2'b11;

reg [1:0] state; // State register
reg [7:0] received_byte; // Buffer for received byte

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        received_byte <= 8'b0;
    end else begin
        case(state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                end
            end
                
            START_BIT: begin
                state <= DATA_BITS;
            end
            
            DATA_BITS: begin
                if (in == 1'b1) begin
                    received_byte <= {received_byte[6:0], in};
                else begin
                    state <= STOP_BIT;
                end
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    out_byte <= received_byte;
                    done <= 1'b1;
                end
            end
        endcase
    end
end

endmodule

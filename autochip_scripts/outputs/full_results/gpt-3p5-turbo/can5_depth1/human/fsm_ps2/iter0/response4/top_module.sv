module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] curr_byte;
reg [7:0] prev_byte;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter RECEIVE_BYTE1 = 2'b01;
parameter RECEIVE_BYTE2 = 2'b10;
parameter RECEIVE_BYTE3 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        curr_byte <= 8'b0;
        prev_byte <= 8'b0;
        state <= IDLE;
    end else begin
        prev_byte <= curr_byte;
        curr_byte <= in;
        
        case (state)
            IDLE:
                if (curr_byte[3] == 1'b1) begin
                    state <= RECEIVE_BYTE1;
                end
            RECEIVE_BYTE1:
                begin
                    if (curr_byte[3] == 1'b1) begin
                        state <= RECEIVE_BYTE2;
                    end else begin
                        state <= IDLE;
                    end
                end
            RECEIVE_BYTE2:
                begin
                    if (curr_byte[3] == 1'b1) begin
                        state <= RECEIVE_BYTE3;
                    end else begin
                        state <= IDLE;
                    end
                end
            RECEIVE_BYTE3:
                begin
                    state <= IDLE;
                end
            default:
                state <= IDLE;
        endcase
    end
end

assign done = (state == RECEIVE_BYTE3);

endmodule

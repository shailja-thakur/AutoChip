module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [3:0] state;
reg [7:0] data;
reg start_bit_detected;
reg stop_bit_detected;

parameter IDLE_STATE = 0;
parameter START_BIT_STATE = 1;
parameter DATA_BIT_STATE = 2;
parameter STOP_BIT_STATE = 3;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE_STATE;
        data <= 8'b0;
        start_bit_detected <= 1'b0;
        stop_bit_detected <= 1'b0;
    end else begin
        case(state)
            IDLE_STATE: begin
                if (in == 1'b0) begin
                    state <= START_BIT_STATE;
                    data <= 8'b0;
                    start_bit_detected <= 1'b1;
                end
            end
            
            START_BIT_STATE: begin
                state <= DATA_BIT_STATE;
                data <= {data[6:0], in};
            end
            
            DATA_BIT_STATE: begin
                if (data == 8'b11111111) begin
                    state <= STOP_BIT_STATE;
                end else begin
                    data <= {data[6:0], in};
                end
            end
            
            STOP_BIT_STATE: begin
                if (in == 1'b1) begin
                    state <= IDLE_STATE;
                    stop_bit_detected <= 1'b1;
                end
            end
        endcase
    end
end

assign done = stop_bit_detected;

endmodule

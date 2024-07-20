module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] byte;
reg start_bit_found;
reg [2:0] bit_counter;

parameter IDLE_STATE = 0;
parameter START_BIT_STATE = 1;
parameter DATA_BIT_STATE = 2;
parameter STOP_BIT_STATE = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE_STATE;
        byte <= 8'h00;
        start_bit_found <= 0;
        bit_counter <= 0;
        done <= 0;
    end else begin
        case(state)
            IDLE_STATE:
                if (in == 1 && start_bit_found == 0)
                    state <= START_BIT_STATE;
                else
                    state <= IDLE_STATE;
            START_BIT_STATE:
                if (bit_counter < 8)
                    state <= DATA_BIT_STATE;
                else if (bit_counter == 8)
                    state <= STOP_BIT_STATE;
            DATA_BIT_STATE:
                if (bit_counter < 8)
                    state <= DATA_BIT_STATE;
                else if (bit_counter == 8)
                    state <= STOP_BIT_STATE;
            STOP_BIT_STATE:
                if (bit_counter < 8)
                    state <= START_BIT_STATE;
                else if (bit_counter == 8) begin
                    state <= IDLE_STATE;
                    done <= 1;
                end
        endcase
    end
end

always @(posedge clk) begin
    if (reset)
        out_byte <= 8'h00;
    else begin
        case(state)
            IDLE_STATE:
                if (in == 1 && start_bit_found == 0)
                    start_bit_found <= 1;
            START_BIT_STATE, DATA_BIT_STATE:
                if (bit_counter < 8) begin
                    byte[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end
            STOP_BIT_STATE:
                if (bit_counter == 8) begin
                    start_bit_found <= 0;
                    bit_counter <= 0;
                    out_byte <= byte;
                end
        endcase
    end
end

endmodule

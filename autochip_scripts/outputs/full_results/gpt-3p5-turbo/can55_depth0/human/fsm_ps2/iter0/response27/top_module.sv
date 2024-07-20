module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg done;

reg [2:0] state;
parameter [2:0] IDLE = 0,
               SEARCH = 1,
               BYTE_2 = 2,
               BYTE_3 = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end else begin
        case (state)
            IDLE:
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= SEARCH;
                end
            SEARCH:
                if (in[3] == 1) begin
                    byte2 <= in;
                    state <= BYTE_2;
                end else begin
                    byte1 <= in;
                end
            BYTE_2:
                if (in[3] == 1) begin
                    byte3 <= in;
                    state <= BYTE_3;
                end else begin
                    byte1 <= in;
                    state <= SEARCH;
                end
            BYTE_3:
                byte1 <= in;
                state <= SEARCH;
                done <= 1;
        endcase
    end
end

endmodule

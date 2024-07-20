module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter WAIT_0 = 3'd0, WAIT_1 = 3'd1, WAIT_2 = 3'd2, WAIT_3 = 3'd3, WAIT_4 = 3'd4, WAIT_5 = 3'd5, WAIT_6 = 3'd6, WAIT_7 = 3'd7;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        case (state)
            WAIT_0: begin
                if (in == 0) state <= WAIT_1;
                else state <= WAIT_0;
            end
            WAIT_1: begin
                if (in == 1) state <= WAIT_2;
                else state <= WAIT_0;
            end
            WAIT_2: begin
                if (in == 1) state <= WAIT_3;
                else state <= WAIT_0;
            end
            WAIT_3: begin
                if (in == 1) state <= WAIT_4;
                else state <= WAIT_0;
            end
            WAIT_4: begin
                if (in == 1) state <= WAIT_5;
                else state <= WAIT_0;
            end
            WAIT_5: begin
                if (in == 1) begin
                    state <= WAIT_6;
                    disc <= 1;
                end
                else state <= WAIT_0;
            end
            WAIT_6: begin
                if (in == 0) begin
                    state <= WAIT_0;
                    disc <= 0;
                    flag <= 1;
                end
                else begin
                    state <= WAIT_7;
                    err <= 1;
                end
            end
            WAIT_7: begin
                if (in == 1) begin
                    err <= 1;
                end
                else begin
                    err <= 0;
                    state <= WAIT_0;
                end
            end
            default: state <= WAIT_0;
        endcase
    end
end

endmodule

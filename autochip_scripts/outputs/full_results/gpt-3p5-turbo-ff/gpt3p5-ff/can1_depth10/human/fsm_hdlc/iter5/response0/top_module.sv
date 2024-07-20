module fsm_hdlc (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    reg [2:0] state;
    reg [6:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else begin
            case (state)
                3'b000: begin // state 0 - looking for 0 after 5 consecutive 1s
                    if (in == 1)
                        state <= 3'b001;
                    else
                        state <= 3'b000;
                end
                3'b001: begin // state 1 - five 1s detected, looking for 0
                    if (in == 1)
                        state <= 3'b010;
                    else
                        state <= 3'b000;
                end
                3'b010: begin // state 2 - zero detected, looking for 1
                    if (in == 1) begin
                        state <= 3'b100;
                        disc <= 1;
                    end
                    else
                        state <= 3'b000;
                end
                3'b100: begin // state 4 - flag detected, looking for another 1
                    if (in == 1) begin
                        state <= 3'b101;
                        flag <= 1;
                    end
                    else
                        state <= 3'b000;
                end
                3'b101: begin // state 5 - flag detected, looking for another 0
                    if (in == 0) begin
                        state <= 3'b110;
                    end
                    else
                        state <= 3'b000;
                end
                3'b110: begin // state 6 - frame end detected
                    if (in == 0) begin
                        state <= 3'b000;
                        flag <= 1;
                    end
                    else
                        state <= 3'b000;
                end
                3'b111: begin // state 7 - error detected
                    state <= 3'b000;
                    err <= 1;
                end
                default: state <= 3'b000;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset)
            count <= 0;
        else if (in == 1)
            count <= count + 1;
        else
            count <= 0;
    end

    always @(posedge clk) begin
        if (reset)
            disc <= 0;
        else
            disc <= 0;
    end

endmodule

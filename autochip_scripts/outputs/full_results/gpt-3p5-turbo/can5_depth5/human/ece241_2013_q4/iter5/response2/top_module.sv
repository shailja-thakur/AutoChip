module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    reg [2:0] state;
    reg [2:0] last_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b100;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else if (s[3]) begin // Above s[3]
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b000;
        end else if (s[2]) begin // Between s[3] and s[2]
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            state <= 3'b001;
        end else if (s[1]) begin // Between s[2] and s[1]
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            state <= 3'b010;
        end else begin // Below s[1]
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
            state <= 3'b100;
        end
        last_state <= state;
    end

    always @(posedge clk) begin
        if (reset) begin
            last_state <= 3'b100;
        end
    end

    always @(negedge clk) begin
        if (reset) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else if (state == 3'b100 && last_state != 3'b100) begin // Transition from Below s[1]
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end
    end

endmodule

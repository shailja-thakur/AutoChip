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
reg [2:0] prev_state;

parameter ABOVES3 = 3'b000;
parameter BETWEENS3S2 = 3'b001;
parameter BETWEENS2S1 = 3'b010;
parameter BEL0WS1 = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= BEL0WS1;
        prev_state <= BEL0WS1;
    end else begin
        case (state)
            ABOVES3: begin
                if (s == 3'b111) begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                    state <= ABOVES3;
                    prev_state <= ABOVES3;
                end else if (s[2:1] == 2'b11) begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                    state <= BETWEENS3S2;
                    prev_state <= ABOVES3;
                end else if (s[1] == 1'b1) begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= 0;
                    state <= BETWEENS2S1;
                    prev_state <= ABOVES3;
                end else begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 0;
                    state <= BEL0WS1;
                    prev_state <= ABOVES3;
                end
            end
            BETWEENS3S2: begin
                if (s == 3'b110) begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 1;
                    dfr <= 0;
                    state <= BETWEENS3S2;
                    prev_state <= BETWEENS3S2;
                end else if (s[1] == 1'b1) begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 1;
                    dfr <= 0;
                    state <= BETWEENS2S1;
                    prev_state <= BETWEENS3S2;
                end else begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= 0;
                    state <= BEL0WS1;
                    prev_state <= BETWEENS3S2;
                end
            end
            BETWEENS2S1: begin
                if (s == 3'b100) begin
                    fr1 <= 0;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 0;
                    state <= BETWEENS2S1;
                    prev_state <= BETWEENS2S1;
                end else begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 1;
                    dfr <= 0;
                    state <= BEL0WS1;
                    prev_state <= BETWEENS2S1;
                end
            end
            BEL0WS1: begin
                if (s == 3'b000) begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 0;
                    state <= BEL0WS1;
                    prev_state <= BEL0WS1;
                end else begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                    state <= ABOVES3;
                    prev_state <= BEL0WS1;
                end
            end
        endcase
    end
end

endmodule

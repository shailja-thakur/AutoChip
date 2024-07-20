module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// FSM states
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;

reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_A;
        count <= 2'b00;
        z <= 1'b0;
    end
    else begin
        case (state)
            STATE_A: begin
                if (s) begin
                    state <= STATE_B;
                    count <= 2'b00;
                end
            end
            STATE_B: begin
                count <= count + 1'b1;
                if (count == 2'b10) begin
                    if (w) begin
                        state <= STATE_C;
                    end
                    else begin
                        state <= STATE_A;
                        z <= 1'b0;
                    end
                end
            end
            STATE_C: begin
                z <= 1'b1;
                state <= STATE_A;
                count <= 2'b00;
            end
        endcase
    end
end

endmodule

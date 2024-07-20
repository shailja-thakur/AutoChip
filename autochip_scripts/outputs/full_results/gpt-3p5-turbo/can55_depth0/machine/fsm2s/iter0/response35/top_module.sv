module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    wire j_next_state;
    wire k_next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00; // State A
        else begin
            case (state)
                2'b00:
                    if (j)
                        state <= 2'b01; // State B
                2'b01:
                    if (k)
                        state <= 2'b00; // State A
            endcase
        end
    end

    assign j_next_state = (state == 2'b00 && j) ? 1'b1 : 1'b0;
    assign k_next_state = (state == 2'b01 && k) ? 1'b1 : 1'b0;

    assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule

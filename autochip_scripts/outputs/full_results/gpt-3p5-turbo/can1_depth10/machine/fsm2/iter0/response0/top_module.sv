module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg [1:0] state;
    reg [1:0] nextState;

    always @(*) begin
        case (state)
            2'b00: nextState = j ? 2'b01 : 2'b00;
            2'b01: nextState = k ? 2'b00 : 2'b01;
        endcase
     end

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;
        else
            state <= nextState;
    end

    always @(posedge clk) begin
        out <= (state == 2'b01) ? 1'b1 : 1'b0;
    end

endmodule

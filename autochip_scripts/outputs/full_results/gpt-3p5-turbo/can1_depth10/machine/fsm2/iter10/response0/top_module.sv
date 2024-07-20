module top_module (
    input wire clk,
    input wire j,
    input wire k,
    input wire areset,
    output reg out
);


    reg [1:0] state;
    reg [1:0] nextState;

    always @(negedge areset or posedge clk) begin
        if (areset)
            state <= 2'b00;
        else
            state <= nextState;
    end

    always @(*) begin
        case (state)
            2'b00: nextState = j ? 2'b10 : 2'b00;
            2'b10: nextState = k ? 2'b00 : 2'b10;
        endcase
    end

    always @(posedge clk or negedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (state == 2'b10);
    end

endmodule

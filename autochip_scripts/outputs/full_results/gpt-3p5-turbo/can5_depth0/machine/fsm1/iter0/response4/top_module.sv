module top_module (
    input wire clk,
    input wire in,
    input wire areset,
    output wire out
);

    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1'b0;
        else begin
            if (state)
                state <= in ? 1'b1 : 1'b0;
            else
                state <= in ? 1'b0 : 1'b1;
        end
    end

    assign out = state;
    
endmodule

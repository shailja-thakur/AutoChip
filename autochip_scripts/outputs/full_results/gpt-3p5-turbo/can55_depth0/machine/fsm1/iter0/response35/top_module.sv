module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 1'b0; // state B
        end else begin
            if (state) begin // state B
                if (in) begin
                    state <= 1'b1; // state B
                end else begin
                    state <= 1'b0; // state A
                end
            end else begin // state A
                if (in) begin
                    state <= 1'b0; // state A
                end else begin
                    state <= 1'b1; // state B
                end
            end
        end
    end

    assign out = state;

endmodule

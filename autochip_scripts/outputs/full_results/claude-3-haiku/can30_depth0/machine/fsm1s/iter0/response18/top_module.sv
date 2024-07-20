module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    parameter A = 1'b0, B = 1'b1;
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            state <= B;
        end
        else begin
            if (state == A) begin
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            else begin // state == B
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
        end
    end

    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule

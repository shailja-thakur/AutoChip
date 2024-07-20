module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg state_A, state_B;

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state_A <= 1;
            state_B <= 0;
        end else begin
            if(state_A) begin
                if(x) begin
                    state_A <= 0;
                    state_B <= 1;
                    z <= 1;
                end else begin
                    state_A <= 1;
                    state_B <= 0;
                    z <= 0;
                end
            end else if(state_B) begin
                if(x) begin
                    state_A <= 0;
                    state_B <= 1;
                    z <= 0;
                end else begin
                    state_A <= 0;
                    state_B <= 1;
                    z <= 1;
                end
            end
        end
    end
endmodule

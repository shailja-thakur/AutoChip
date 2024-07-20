module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg state, next_state;

    always @(*) begin
        if(state == 1'b0) begin
            if(j)
                next_state = 1'b1;
            else
                next_state = 1'b0;
        end else begin
            if(k)
                next_state = 1'b0;
            else
                next_state = 1'b1;
        end
    end

    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= 1'b0;
        else
            state <= next_state;
    end

    assign out = state;
    
endmodule

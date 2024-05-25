    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 1;
        else if (train_valid) begin
            if(state < 3 && train_taken)
                state <= state + 1;
            else if(state > 0 && !train_taken)
                state <= state - 1;
        end
    end
endmodule

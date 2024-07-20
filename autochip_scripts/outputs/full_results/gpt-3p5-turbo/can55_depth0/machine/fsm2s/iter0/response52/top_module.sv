module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    reg [1:0] state;
    always @(posedge clk) begin
        if (reset)
            state <= 2'b00;  // State A
        else begin
            if (state == 2'b00) begin  // State A
                if (j)
                    state <= 2'b01;  // State B
                else
                    state <= 2'b00;  // State A
            end else begin  // State B
                if (k)
                    state <= 2'b00;  // State A
                else
                    state <= 2'b01;  // State B
            end
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;  // Output high when state is B, low when state is A
endmodule

module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    wire next_state;
    
    assign next_state = areset ? 2'b10 : (state == 2'b00 && !in ? 2'b10 : (state == 2'b00 && in ? 2'b01 : (state == 2'b01 && !in ? 2'b10 : (state == 2'b01 && in ? 2'b01 : (state == 2'b10 && !in ? 2'b01 : 2'b10)))));
    
    always @(posedge clk) begin
        if (areset) begin
            state <= 2'b10;
        end else begin
            state <= next_state;
        end
    end
    
    assign out = state[1];
    
endmodule

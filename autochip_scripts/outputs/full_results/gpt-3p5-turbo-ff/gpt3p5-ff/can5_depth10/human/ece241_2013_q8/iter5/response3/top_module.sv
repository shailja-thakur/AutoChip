module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [2:0] state;
    wire x_delay;
    
    always @(posedge clk) begin
        if (~aresetn) begin
            state <= 3'b000;
            z <= 0;
        end else begin
            state <= {state[1:0], x_delay};
            z <= 0;
            if (state == 3'b100)
                z <= 1;
        end
    end

    assign x_delay = #(0.5) x;
    
endmodule

module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state, state_next;
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= 2'b0;
        end else begin
            state <= state_next;
        end
    end
    
    always @(*) begin
        case (state)
            2'b00: state_next = (x == 1) ? 2'b01 : 2'b00;
            2'b01: state_next = (x == 0) ? 2'b10 : 2'b01;
            2'b10: state_next = (x == 1) ? 2'b01 : 2'b00;
        endcase
    end
    
    always @(state) begin
        case (state)
            2'b00, 2'b01: z = 1'b0;
            2'b10: z = x;
        endcase
    end

endmodule

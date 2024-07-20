module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;
    wire [1:0] next_state;
    
    // Moore state machine equations
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00; // Reset to state A
        else
            state <= next_state;
    end
    
    // Moore state machine outputs
    always @(state) begin
        case (state)
            2'b00: begin
                out_reg = 1'b0;
                next_state = (in) ? 2'b01 : 2'b10;
            end
            2'b01: begin
                out_reg = 1'b0;
                next_state = (in) ? 2'b10 : 2'b01;
            end
            2'b10: begin
                out_reg = 1'b0;
                next_state = (in) ? 2'b00 : 2'b11;
            end
            2'b11: begin
                out_reg = 1'b1;
                next_state = (in) ? 2'b10 : 2'b01;
            end
        endcase
    end
    
    // Output register
    always @(posedge clk) begin
        out <= out_reg;
    end

endmodule

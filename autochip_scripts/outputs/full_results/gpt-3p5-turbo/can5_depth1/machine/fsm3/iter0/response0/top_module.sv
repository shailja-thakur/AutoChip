module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    
    // state variable definition
    reg [1:0] state;
    
    // assign output
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;
    
    // state machine logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end else begin
            case(state)
                2'b00: begin
                    state <= (in) ? 2'b01 : 2'b00;
                end
                2'b01: begin
                    state <= (in) ? 2'b01 : 2'b10;
                end
                2'b10: begin
                    state <= (in) ? 2'b11 : 2'b00;
                end
                2'b11: begin
                    state <= (in) ? 2'b01 : 2'b10;
                end
            endcase
        end
    end
    
endmodule

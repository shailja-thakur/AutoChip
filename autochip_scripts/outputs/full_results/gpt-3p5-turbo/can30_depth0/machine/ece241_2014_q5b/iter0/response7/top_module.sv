module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // A state
        end else begin
            case(state)
                2'b00: begin
                    if (x) begin
                        state <= 2'b01; // B state
                    end else begin
                        state <= 2'b00; // A state
                    end
                end
                2'b01: begin
                    state <= 2'b01; // B state
                end
            endcase
        end
    end
    
    assign z = (state == 2'b00 && x) || (state == 2'b01 && !x);
endmodule

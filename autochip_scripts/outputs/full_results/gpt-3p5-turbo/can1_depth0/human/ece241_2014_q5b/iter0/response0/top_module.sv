module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;  // state A
        end else begin
            case(state)
                2'b00: begin  // state A
                    if (x) begin
                        state <= 2'b01;  // state B
                        z <= 1'b1;
                    end else begin
                        state <= 2'b00;  // state A
                        z <= 1'b0;
                    end 
                end
                2'b01: begin  // state B
                    if (x) begin
                        state <= 2'b01;  // state B
                        z <= 1'b0;
                    end else begin
                        state <= 2'b01;  // state B
                        z <= 1'b1;
                    end
                end
            endcase
        end
    end
    
endmodule

module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state, x) begin
        case (state)
            2'b00: begin
                if (areset) begin
                    next_state <= 2'b01;
                end else if (x) begin
                    next_state <= 2'b10;
                end else begin
                    next_state <= 2'b00;
                end
                z <= 1'b0;
            end
            
            2'b01: begin
                if (areset) begin
                    next_state <= 2'b00;
                end else if (x) begin
                    next_state <= 2'b10;
                end else begin
                    next_state <= 2'b01;
                end
                z <= ~z;
            end
            
            2'b10: begin
                if (areset) begin
                    next_state <= 2'b01;
                end else if (x) begin
                    next_state <= 2'b10;
                end else begin
                    next_state <= 2'b00;
                end
                z <= x;
            end
            
            default: begin
                if (areset) begin
                    next_state <= 2'b00;
                end else if (x) begin
                    next_state <= 2'b10;
                end else begin
                    next_state <= 2'b00;
                end
                z <= 1'b0;
            end
        endcase
    end
endmodule

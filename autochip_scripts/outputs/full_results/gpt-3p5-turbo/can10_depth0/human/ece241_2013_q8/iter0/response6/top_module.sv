module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 2'b00;
    end else begin
        state <= next_state;
    end
end

always @(state or x) begin
    case (state)
        2'b00: begin
            if (x == 1'b1) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b00;
            end
        end
        
        2'b01: begin
            if (x == 1'b1) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b00;
            end
        end
        
        2'b10: begin
            if (x == 1'b1) begin
                next_state = 2'b11;
            end else begin
                next_state = 2'b00;
            end
        end
        
        2'b11: begin
            if (x == 1'b1) begin
                next_state = 2'b11;
            end else begin
                next_state = 2'b00;
            end
        end
    endcase
end

always @(state) begin
    if (state == 2'b11) begin
        z = 1'b1;
    end else begin
        z = 1'b0;
    end
end

endmodule

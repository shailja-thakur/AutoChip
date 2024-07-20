module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        0: begin
            if (x == 1'b1) begin
                next_state = 1;
                z = 0;
            end else begin
                next_state = 0;
                z = 0;
            end
        end
        
        1: begin
            if (x == 1'b0) begin
                next_state = 0;
                z = 0;
            end else begin
                next_state = 2;
                z = 0;
            end
        end
        
        2: begin
            if (x == 1'b1) begin
                next_state = 0;
                z = 1'b1;
            end else begin
                next_state = 2;
                z = 0;
            end
        end
    endcase
end

endmodule

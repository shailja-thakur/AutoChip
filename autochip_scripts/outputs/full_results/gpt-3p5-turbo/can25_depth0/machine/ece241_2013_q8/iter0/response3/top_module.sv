module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [2:0] state, next_state;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= 3'b0; // Initial state
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            3'b000: begin
                if (x == 1'b0) begin
                    next_state = 3'b000;
                end else begin
                    next_state = 3'b001;
                end
                z = 1'b0;
            end
            3'b001: begin
                if (x == 1'b0) begin
                    next_state = 3'b010;
                end else begin
                    next_state = 3'b001;
                end
                z = 1'b0;
            end
            3'b010: begin
                if (x == 1'b0) begin
                    next_state = 3'b000;
                end else begin
                    next_state = 3'b001;
                end
                z = x;
            end
        endcase
    end

endmodule

module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] INIT = 2'b00, 
                 S1   = 2'b01, 
                 S2   = 2'b10,
                 S3   = 2'b11;

reg [1:0] current_state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        current_state <= INIT;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        INIT: begin
            z = 1'b0;
            if (x) begin
                next_state = S1;
            end
            else begin
                next_state = INIT;
            end
        end
        S1: begin
            z = 1'b0;
            if (x) begin
                next_state = S2;
            end
            else begin
                next_state = INIT;
            end
        end
        S2: begin
            z = 1'b0;
            if (~x) begin
                next_state = S3;
            end
            else begin
                next_state = S1;
            end
        end
        S3: begin
            z = 1'b1;
            if (x) begin
                next_state = S1;
            end
            else begin
                next_state = INIT;
            end
        end
        default: begin
            z = 1'b0;
            next_state = INIT;
        end
    endcase
end

endmodule

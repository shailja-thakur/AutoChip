module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state, next_state;
    
    always @(*) begin
        case (state)
            2'b00: begin // S
                if (x == 1'b0) begin
                    next_state = 2'b00; // S
                end
                else begin
                    next_state = 2'b01; // S1
                end
            end
            2'b01: begin // S1
                if (x == 1'b0) begin
                    next_state = 2'b10; // S10
                end
                else begin
                    next_state = 2'b01; // S1
                end
            end
            2'b10: begin // S10
                if (x == 1'b0) begin
                    next_state = 2'b00; // S
                end
                else begin
                    next_state = 2'b01; // S1
                end
            end
            default: begin
                next_state = 2'b00; // S
            end
        endcase
    end
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= 2'b00; // S
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            2'b00: begin // S
                z = 1'b0;
            end
            2'b01: begin // S1
                z = 1'b0;
            end
            2'b10: begin // S10
                z = x;
            end
            default: begin
                z = 1'b0;
            end
        endcase
    end

endmodule

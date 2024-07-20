module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
    reg [2:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case(state)
            3'b000: begin
                if (w) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b010;
                end
            end
            3'b001: begin
                if (w) begin
                    next_state = 3'b000;
                end else begin
                    next_state = 3'b010;
                end
            end
            3'b010: begin
                if (w) begin
                    next_state = 3'b100;
                end else begin
                    next_state = 3'b011;
                end
            end
            3'b011: begin
                if (w) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b011;
                end
            end
            3'b100: begin
                if (w) begin
                    next_state = 3'b101;
                end else begin
                    next_state = 3'b110;
                end
            end
            3'b101: begin
                if (w) begin
                    next_state = 3'b101;
                end else begin
                    next_state = 3'b011;
                end
            end
            3'b110: begin
                if (w) begin
                    next_state = 3'b010;
                end else begin
                    next_state = 3'b011;
                end
            end
            default: begin
                next_state = 3'b000;
            end
        endcase
    end
    
    always @(posedge clk) begin
        case(state)
            3'b000: z <= 1'b0;
            3'b001: z <= 1'b0;
            3'b010: z <= 1'b0;
            3'b011: z <= 1'b0;
            3'b100: z <= 1'b0;
            3'b101: z <= 1'b1;
            3'b110: z <= 1'b1;
            default: z <= 1'b0;
        endcase
    end
    
endmodule

module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b0;
        end else begin
            case (state)
                3'b000: begin // State A
                    if (w) begin
                        state <= 3'b001; // Transition to State B
                    end else begin
                        state <= 3'b000; // Transition to State A
                    end
                end
                3'b001: begin // State B
                    if (w) begin
                        state <= 3'b010; // Transition to State C
                    end else begin
                        state <= 3'b100; // Transition to State D
                    end
                end
                3'b010: begin // State C
                    if (w) begin
                        state <= 3'b101; // Transition to State E
                    end else begin
                        state <= 3'b100; // Transition to State D
                    end
                end
                3'b100: begin // State D
                    if (w) begin
                        state <= 3'b111; // Transition to State F
                    end else begin
                        state <= 3'b000; // Transition to State A
                    end
                end
                3'b101: begin // State E
                    if (w) begin
                        state <= 3'b101; // Transition to State E
                    end else begin
                        state <= 3'b100; // Transition to State D
                    end
                end
                3'b111: begin // State F
                    if (w) begin
                        state <= 3'b010; // Transition to State C
                    end else begin
                        state <= 3'b100; // Transition to State D
                    end
                end
            endcase
        end
    end
    
    assign z = (state == 3'b101) || (state == 3'b111);
    
endmodule

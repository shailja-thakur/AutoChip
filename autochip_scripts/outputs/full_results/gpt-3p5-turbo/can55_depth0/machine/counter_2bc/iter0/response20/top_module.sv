module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    reg [1:0] nextState;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else begin
            case (state)
                2'b00: begin
                    if (train_valid && train_taken) begin
                        nextState <= 2'b01;
                    end else if (train_valid && !train_taken) begin
                        nextState <= 2'b00;
                    end else begin
                        nextState <= state;
                    end
                end
                2'b01: begin
                    if (train_valid && train_taken) begin
                        nextState <= 2'b10;
                    end else if (train_valid && !train_taken) begin
                        nextState <= 2'b00;
                    end else begin
                        nextState <= state;
                    end
                end
                2'b10: begin
                    if (train_valid && train_taken) begin
                        nextState <= 2'b11;
                    end else if (train_valid && !train_taken) begin
                        nextState <= 2'b01;
                    end else begin
                        nextState <= state;
                    end
                end
                2'b11: begin
                    if (!train_valid || !train_taken) begin
                        nextState <= 2'b10;
                    end else begin
                        nextState <= state;
                    end
                end
                default: begin
                    nextState <= state;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        state <= nextState;
    end

endmodule

module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else begin
            case ({train_valid, train_taken})
                2'b11: state <= (state == 2'b11) ? 2'b11 : state + 1;
                2'b10: state <= (state == 2'b00) ? 2'b00 : state - 1;
            endcase
        end
    end
endmodule

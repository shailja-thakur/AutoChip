module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    logic [1:0] counter;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            counter <= 2'b01;
        else if (train_valid) begin
            case (counter)
                2'b00: if (train_taken) counter <= 2'b01;
                2'b01: if (train_taken) counter <= 2'b10;
                        else counter <= 2'b00;
                2'b10: if (train_taken) counter <= 2'b11;
                        else counter <= 2'b01;
                2'b11: if (!train_taken) counter <= 2'b10;
            endcase
        end
    end
    
    assign state = counter;
    
endmodule
